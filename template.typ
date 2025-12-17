#import "@preview/fontawesome:0.5.0": *

// --------------------------------------
// Theme
// --------------------------------------

#let current-background-color = state("current-background-color", rgb("ffffff"))

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

#let get-current-background-color() = {
  current-background-color.at(here())
}

#let set-current-background-color(col) = {
  current-background-color.update(c => col)
}

#let small(content) = {
  text(size: 10pt)[#content]
}

#let medium(content) = {
  text(size: 14pt, weight: "bold")[#content]
}

#let large(content) = {
  text(size: 18pt, weight: "bold")[#content]
}

#let theme(
  accent-color: none,
  background-color: none,
) = {
  let config = (:) // empty dictionary
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

#let contact-block(contact-info) = small[
  #contact-info
]

#let recipient-block(recipient-info) = small[
  #recipient-info
]

#let language-flags = (
  // Germanic
  "english": "gb",
  "german": "de",
  "dutch": "nl",
  "swedish": "se",
  "norwegian": "no",
  "danish": "dk",
  "icelandic": "is",

  // Romance
  "french": "fr",
  "spanish": "es",
  "portuguese": "pt",
  "italian": "it",
  "romanian": "ro",

  // Slavic
  "russian": "ru",
  "polish": "pl",
  "czech": "cz",
  "slovak": "sk",
  "ukrainian": "ua",

  // Others (Europe)
  "greek": "gr",
  "finnish": "fi",
  "hungarian": "hu",

  // Middle East / Africa
  "arabic": "sa",
  "hebrew": "il",
  "turkish": "tr",

  // Asia
  "chinese": "cn",
  "japanese": "jp",
  "korean": "kr",
  "hindi": "in",
  "thai": "th",
  "vietnamese": "vn",
  "indonesian": "id",
)

#let language(lang, prof, cc: none, img: none) = {
  if img == none {
    if cc == none {
      let key = lower(lang)
      cc = language-flags.at(key, default: "un")
    }
    img = "assets/flags/svg/" + cc + ".svg"
  }

  [
    #box(baseline: 0.2em, image(img, height: 1em)) #h(0.5em) #lang (#prof)#linebreak()
  ]
}

// White text on darker background, black on light ones (with bias)
#let detect-text-color = (bg-color) => {
  let rgb = bg-color.rgb()
  let r = rgb.components().at(1)
  let g = rgb.components().at(1)
  let b = rgb.components().at(2)

  let total = r + g + b
  if total > 220% {
    black
  } else {
    white
  }
}

// Image box (optionally framed)
#let foto-box(img, size: 5cm, padding: 4pt, radius: 0pt) = {
  align(center)[ #box(
    fill: white,
    inset: padding,
    radius: radius,
    box(
      radius: radius * .5,
      clip: true,
      img,
    ),
  )]
}

// Create a short summary section for the sidebar
#let summary(content) = [
  #line(length: 100%, stroke: white)
  #v(5pt)

  #small[#content]

  #v(5pt)
  #line(length: 100%, stroke: white)
]

// Creates a monospace bullet item
#let tag(content) = [
  #context [
    #box(
      fill: get-accent-color().lighten(50%),
      inset: (x: 8pt, y: 4pt),
      radius: 4pt,
      text(
        size: 10pt,
        fill: rgb(get-accent-color()).darken(40%),
        weight: "medium",
      )[#content],
    )
    #h(1pt)
  ]
]

// Creates a group of tags
#let tags(..items) = {
  box(width: 100%, clip: true, {
    for item in items.pos() {
      tag(item)
      h(4pt)
    }
  })
}

// Creates a monospace bullet item with an icon
#let icon-tag(name, icon: none) = {
  if icon == none {
    icon = "assets/devicons/svg/" + lower(name) + ".svg"
  } else if icon == "" {
    icon = "assets/devicons/svg/placeholder.svg"
  }

  let base = .15em
  tag([
    #box(baseline: base, image(icon, height: 1em))
    #h(.2em)
    #text(font: "IBM Plex Mono")[ #name ]
  ])
}

// Creates a group of iconTags
#let icon-tags(..items) = {
  box(width: 100%, clip: true, {
    for item in items.pos() {
      if type(item) == array {
        let (name, icon) = item
        icon-tag(name, icon: icon)
      } else {
        icon-tag(item)
      }
      h(.2em)
    }
  })
}

#let section(icon: "", name, content) = {
  context {
    let icon-str = if icon == "" { "" } else { [#fa-icon(icon) #h(8pt)] }
    let title = [== #icon-str#underline[#name]]

    text(font: "IBM Plex Mono")[ #title ]
    pad(y: 16pt)[#content]
  }
}

#let resume-layout = (
  sidebar: none,
  color: gray,
  base-color: white,
  content,
) => {
  if sidebar == none {
    pad(20pt, content)
  } else {
    grid(
      columns: (1.9fr, 3fr),
      rows: (100%),
      fill: (x, _) => if x == 0 { color } else { base-color },
      context {
        set-current-background-color(color)
        sidebar
      }, context {
        set-current-background-color(base-color)
        content
      },
    )
  }
}

#let contact = (
  phone: "",
  github: "",
  location: "",
  email: "",
  linkedin: "",
  website: "",
  x: "",
) => {
  if email != "" [
    #fa-envelope(solid: true) #h(5pt) #email \
  ]
  if phone != "" [
    #fa-phone(solid: true) #h(5pt) #phone \
  ]
  if github != "" [
    #fa-github(solid: true) #h(5pt) #github \
  ]
  if linkedin != "" [
    #fa-linkedin(solid: true) #h(5pt) #linkedin \
  ]
  if location != "" [
    #fa-location-dot(solid: true) #h(5pt) #location \
  ]
  if website != "" [
    #fa-globe(solid: false) #h(5pt) #website \
  ]
  if x != "" [
    #fa-x-twitter(solid: true) #h(5pt) #x \
  ]
}

#let render-area(text-fill, content) = {
  pad(y: 20pt, left: 20pt, right: 14pt, [
    #set text(font: font, fill: text-fill, size: 12pt)
    #content
  ])
}

#let resume-page = (sidebar: none, main) => {
  context {
    set page("a4", margin: 0pt, fill: get-background-color())
    resume-layout(
      base-color: get-background-color(),
      color: get-accent-color(),
      sidebar: if sidebar != none {
        render-area(
          detect-text-color(get-accent-color()),
          sidebar,
        )
      } else {
        none
      },
      render-area(
        detect-text-color(get-background-color()),
        main,
      ),
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
) = [ #resume-page(
  [ #pad(
    rest: 5%,
    [
      #contact-block(contact-info)
      #v(2em)

      #recipient-block(recipient-info)
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
    ],
  )],
)]
