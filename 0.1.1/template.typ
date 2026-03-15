#import "@preview/fontawesome:0.5.0": *

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

#let section(icon: "", name, content) = {
  let icon-str = if icon == "" { "" } else { [#fa-icon(icon) #h(8pt)] }
  text(font: "IBM Plex Mono")[== #icon-str#underline[#name]]
  pad(y: 16pt)[#content]
}

#let contact(
  phone: "",
  github: "",
  location: "",
  email: "",
  linkedin: "",
  website: "",
  x: "",
) = {
  if email != "" [#fa-envelope(solid: true) #h(5pt) #email \]
  if phone != "" [#fa-phone(solid: true) #h(5pt) #phone \]
  if github != "" [#fa-github(solid: true) #h(5pt) #github \]
  if linkedin != "" [#fa-linkedin(solid: true) #h(5pt) #linkedin \]
  if location != "" [#fa-location-dot(solid: true) #h(5pt) #location \]
  if website != "" [#fa-globe(solid: false) #h(5pt) #website \]
  if x != "" [#fa-x-twitter(solid: true) #h(5pt) #x \]
}

#let render-area(text-fill, content) = {
  pad(y: 20pt, left: 20pt, right: 14pt, [
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
