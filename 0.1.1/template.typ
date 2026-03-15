// --------------------------------------
// Theme
// --------------------------------------

#let theme-state = state("theme", (
  accent-color: rgb("BAC7CE"),
  background-color: rgb("F2F0EF"),
))

#let get-background-color() = {
  theme-state.at(here()).background-color
}

#let get-accent-color() = {
  theme-state.at(here()).accent-color
}

#let theme(
  accent-color: none,
  background-color: none,
) = {
  let config = (:)
  if accent-color != none {
    config.insert("accent-color", accent-color)
  }
  if background-color != none {
    config.insert("background-color", background-color)
  }
  theme-state.update(it => it + config)
}

// --------------------------------------
// Config
// --------------------------------------

#show heading.where(level: 1): set text(size: 22pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")

#let font = "IBM Plex Sans"

// --------------------------------------
// Helpers
// --------------------------------------

// White text on darker backgrounds, black on light ones
#let detect-text-color(bg-color) = {
  let components = bg-color.rgb().components()
  let r = components.at(0)
  let g = components.at(1)
  let b = components.at(2)
  if r + g + b > 220% { black } else { white }
}

#let small(content) = text(size: 10pt)[#content]

#let medium(content) = text(size: 14pt, weight: "bold")[#content]

#let large(content) = text(size: 18pt, weight: "bold")[#content]

// Image box (optionally framed)
#let photo-box(img, padding: 4pt, radius: 0pt) = {
  align(center)[
    #box(
      fill: white,
      inset: padding,
      radius: radius,
      box(radius: radius * .5, clip: true, img),
    )
  ]
}

// Short summary section for the sidebar
#let summary(content) = [
  #line(length: 100%, stroke: white)
  #v(5pt)
  #small[#content]
  #v(5pt)
  #line(length: 100%, stroke: white)
]

// Individual styled tag pill
#let tag(content) = context [
  #box(
    fill: get-accent-color().lighten(50%),
    inset: (x: 8pt, y: 4pt),
    radius: 4pt,
    text(
      size: 10pt,
      fill: get-accent-color().darken(40%),
      weight: "medium",
    )[#content],
  )
]

#let tags(..items) = {
  box(width: 100%, clip: true, {
    for item in items.pos() {
      tag(item)
      h(5pt)
    }
  })
}

#let icon-tag(name, icon: none) = {
  if icon == none {
    icon = "assets/devicons/svg/" + lower(name) + ".svg"
  } else if icon == "" {
    icon = "assets/devicons/svg/placeholder.svg"
  }
  tag([
    #box(baseline: .15em, image(icon, height: 1em))
    #h(.2em)
    #text(font: "IBM Plex Mono")[#name]
  ])
}

#let icon-tags(..items) = {
  box(width: 100%, clip: true, {
    for item in items.pos() {
      if type(item) == array {
        let (name, icon) = item
        icon-tag(name, icon: icon)
      } else {
        icon-tag(item)
      }
      h(5pt)
    }
  })
}

#let language(lang, prof) = [
  #lang (#prof)#linebreak()
]

#let section(name, content) = {
  text(font: "IBM Plex Mono")[== #underline[#name]]
  pad(top: 8pt, bottom: 24pt)[#content]
}

// SVG path data (24×24 viewBox) for contact field icons
#let _icon-paths = (
  email:    "M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z",
  phone:    "M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.3.2 2.5.6 3.6.1.3 0 .7-.2 1L6.6 10.8z",
  github:   "M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z",
  linkedin: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z",
  location: "M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z",
  website:  "M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z",
  x:        "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-4.714-6.231-5.401 6.231H2.744l7.73-8.835L1.254 2.25H8.08l4.253 5.622zm-1.161 17.52h1.833L7.084 4.126H5.117z",
)

#let _contact-icon(name, fill: "#000000") = {
  let svg = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><path fill='" + fill + "' d='" + _icon-paths.at(name) + "'/></svg>"
  box(baseline: 0.15em, image(bytes(svg), format: "svg", height: 0.85em))
}

#let contact(
  phone: "",
  github: "",
  location: "",
  email: "",
  linkedin: "",
  website: "",
  x: "",
) = context {
  let fill = if detect-text-color(get-accent-color()) == black { "#000000" } else { "#ffffff" }
  if email != "" [#_contact-icon("email", fill: fill) #h(4pt) #email#linebreak()]
  if phone != "" [#_contact-icon("phone", fill: fill) #h(4pt) #phone#linebreak()]
  if github != "" [#_contact-icon("github", fill: fill) #h(4pt) #github#linebreak()]
  if linkedin != "" [#_contact-icon("linkedin", fill: fill) #h(4pt) #linkedin#linebreak()]
  if location != "" [#_contact-icon("location", fill: fill) #h(4pt) #location#linebreak()]
  if website != "" [#_contact-icon("website", fill: fill) #h(4pt) #website#linebreak()]
  if x != "" [#_contact-icon("x", fill: fill) #h(4pt) #x#linebreak()]
}

#let render-area(text-fill, content) = {
  pad(20pt, [
    #set text(font: font, fill: text-fill, size: 12pt)
    #content
  ])
}

#let resume-layout(sidebar: none, color: gray, base-color: white, content) = {
  if sidebar == none {
    pad(20pt, content)
  } else {
    grid(
      columns: (1.9fr, 3fr),
      rows: (100%),
      fill: (x, _) => if x == 0 { color } else { base-color },
      sidebar,
      content,
    )
  }
}

#let resume-page(sidebar: none, main) = {
  context {
    set page("a4", margin: 0pt, fill: get-background-color())
    resume-layout(
      base-color: get-background-color(),
      color: get-accent-color(),
      sidebar: if sidebar != none {
        render-area(detect-text-color(get-accent-color()), sidebar)
      } else {
        none
      },
      render-area(detect-text-color(get-background-color()), main),
    )
  }
}

#let cover-letter(
  contact-info,
  recipient-info,
  city: "",
  date: none,
  letter-title,
  content,
) = [
  #resume-page([
    #pad(rest: 5%, [
      #small[#contact-info]
      #v(2em)

      #small[#recipient-info]
      #v(2em)

      #if city != "" {
        if not city.contains(",") {
          city = [#city, ]
        } else {
          city = [#city ]
        }
      }
      #if date == none {
        date = datetime.today().display("[day].[month].[year]")
      }
      #align(right)[#small[#city#date]]
      #h(2em)

      = #letter-title
      #h(4em)

      #content
    ]),
  ])
]
