module Admin
  class StripeController < Admin::BaseController
    # GET /admin/stripe — show connect status
    def show
      @connected = SiteConfig.stripe_connected?
      if @connected
        Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
        @account = Stripe::Account.retrieve(SiteConfig.stripe_account_id) rescue nil
      end
    end

    # POST /admin/stripe/connect — start onboarding
    def connect
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

      account = Stripe::Account.create(
        type: "standard",
        metadata: { platform: "spaceman_tech" }
      )

      SiteConfig.set("stripe_account_id", account.id)

      account_link = Stripe::AccountLink.create(
        account: account.id,
        refresh_url: admin_stripe_refresh_url,
        return_url: admin_stripe_return_url,
        type: "account_onboarding"
      )

      redirect_to account_link.url, allow_other_host: true
    end

    # GET /admin/stripe/return — guide comes back from Stripe
    def return_from_stripe
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      account_id = SiteConfig.stripe_account_id

      if account_id
        account = Stripe::Account.retrieve(account_id)
        if account.charges_enabled
          SiteConfig.set("stripe_onboarding_complete", "true")
          redirect_to admin_stripe_path, notice: "Stripe connected. You are ready to accept payments."
        else
          redirect_to admin_stripe_path, alert: "Onboarding incomplete. Please finish setting up your Stripe account."
        end
      else
        redirect_to admin_stripe_path, alert: "Something went wrong. Please try again."
      end
    end

    # GET /admin/stripe/refresh — Stripe link expired, generate new one
    def refresh
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      account_id = SiteConfig.stripe_account_id

      if account_id
        account_link = Stripe::AccountLink.create(
          account: account_id,
          refresh_url: admin_stripe_refresh_url,
          return_url: admin_stripe_return_url,
          type: "account_onboarding"
        )
        redirect_to account_link.url, allow_other_host: true
      else
        redirect_to admin_stripe_path, alert: "No Stripe account found. Please connect first."
      end
    end

    # DELETE /admin/stripe/disconnect
    def disconnect
      SiteConfig.where(key: ["stripe_account_id", "stripe_onboarding_complete"]).destroy_all
      redirect_to admin_stripe_path, notice: "Stripe account disconnected."
    end
  end
end
