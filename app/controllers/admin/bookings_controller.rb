module Admin
  class BookingsController < Admin::BaseController
    def index
      @upcoming = Booking.includes(:package)
                         .confirmed
                         .where("tour_date >= ?", Date.today)
                         .order(:tour_date)
      @bookings = Booking.includes(:package).order(created_at: :desc).page(params[:page]).per(30)

      @stats = {
        upcoming_count:    @upcoming.count,
        this_month:        Booking.confirmed.where(tour_date: Date.today.beginning_of_month..Date.today.end_of_month).count,
        pending_count:     Booking.pending.count,
        total_revenue:     Booking.confirmed.sum(:amount_paid_cents) / 100
      }
    end

    def show
      @booking = Booking.includes(:package).find(params[:id])
    end

    def calendar
      @booking = Booking.includes(:package).find(params[:id])
      ics = build_ics(@booking)
      send_data ics,
        filename: "paris-unveiled-#{@booking.id}.ics",
        type: "text/calendar",
        disposition: "attachment"
    end

    def feed
      @bookings = Booking.includes(:package).confirmed.where("tour_date >= ?", Date.today).order(:tour_date)
      ics = build_feed(@bookings)
      send_data ics,
        filename: "paris-unveiled-calendar.ics",
        type: "text/calendar",
        disposition: "inline"
    end

    private

    def build_ics(booking)
      start_dt = booking.tour_date.strftime("%Y%m%d")
      duration_h = booking.package.duration.to_i.nonzero? || 3
      <<~ICS
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:-//Paris Unveiled//Bookings//EN
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        #{vevent(booking)}
        END:VCALENDAR
      ICS
    end

    def build_feed(bookings)
      events = bookings.map { |b| vevent(b) }.join("\n")
      <<~ICS
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:-//Paris Unveiled//Bookings//EN
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME:Paris Unveiled Tours
        #{events}
        END:VCALENDAR
      ICS
    end

    def vevent(booking)
      hours = booking.package.duration.scan(/\d+/).first.to_i
      hours = 3 if hours.zero?
      start_t = booking.tour_date.strftime("%Y%m%d") + "T100000"
      end_t   = booking.tour_date.strftime("%Y%m%d") + "T#{format('%02d', 10 + hours)}0000"
      <<~EVENT.strip
        BEGIN:VEVENT
        UID:booking-#{booking.id}@unveiledparis.com
        DTSTAMP:#{Time.now.utc.strftime("%Y%m%dT%H%M%SZ")}
        DTSTART:#{start_t}
        DTEND:#{end_t}
        SUMMARY:#{booking.package.name} — #{booking.full_name}
        DESCRIPTION:#{booking.group_size} guests\\n#{booking.email}\\n#{booking.phone}#{booking.special_requests.present? ? "\\nNotes: #{booking.special_requests}" : ""}
        END:VEVENT
      EVENT
    end
  end
end
