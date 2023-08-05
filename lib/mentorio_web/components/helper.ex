defmodule MentorioWeb.Helper do
  use MentorioWeb, :html

  attr :date, :any, required: true

  def formattedDate(assigns) do
    ~H"""
    <%= Calendar.strftime(assigns.date, "%A %d.%m.%Y") %>
    """
  end

  def logo(assigns) do
    ~H"""
    <div class="hover:opacity-80 inline-block">
      <svg viewBox="0 0 36 36" fill="none" role="img" xmlns="http://www.w3.org/2000/svg" width="35">
        <mask id=":rks:" maskUnits="userSpaceOnUse" x="0" y="0" width="36" height="36">
          <rect
            width="36"
            height="36"
            rx="72"
            fill="#FFFFFF"
            style="--darkreader-inline-fill: #e8e6e3;"
            data-darkreader-inline-fill=""
          />
        </mask>
        <g mask="url(#:rks:)">
          <rect
            width="36"
            height="36"
            fill="rgb(99, 102, 241)"
            style="--darkreader-inline-fill: #aa6800;"
            data-darkreader-inline-fill=""
          />
          <rect
            x="0"
            y="0"
            width="36"
            height="36"
            transform="translate(6 -2) rotate(116 18 18) scale(1.2)"
            fill="rgb(99, 102, 241)"
            rx="6"
            style="--darkreader-inline-fill: #3a0065;"
            data-darkreader-inline-fill=""
          />
          <g transform="translate(4 -4) rotate(6 18 18)">
            <path
              d="M15 21c2 1 4 1 6 0"
              stroke="#FFFFFF"
              fill="none"
              stroke-linecap="round"
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
            <rect
              x="13"
              y="14"
              width="1.5"
              height="2"
              rx="1"
              stroke="none"
              fill="#FFFFFF"
              style="--darkreader-inline-fill: #e8e6e3; --darkreader-inline-stroke: none;"
              data-darkreader-inline-fill=""
              data-darkreader-inline-stroke=""
            />
            <rect
              x="21"
              y="14"
              width="1.5"
              height="2"
              rx="1"
              stroke="none"
              fill="#FFFFFF"
              style="--darkreader-inline-fill: #e8e6e3; --darkreader-inline-stroke: none;"
              data-darkreader-inline-fill=""
              data-darkreader-inline-stroke=""
            />
          </g>
        </g>
      </svg>
    </div>
    """
  end
end
