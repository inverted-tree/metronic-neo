#import "@preview/metronic-neo:0.1.0": *

#theme(
  accent-color: rgb("61B7AE"),
  background-color: rgb("F2F0EF"),
)

#show: resume-page.with(sidebar: [

  = Byte O. Verflow

  #medium("Senior Brainf*ck Developer")

  #v(5pt)

  #summary([Senior Brainfuck engineer with 10+ years of experience.
  Known for building production-ready software in a language nobody else knows.
  Strong focus on pointer acrobatics and explaining my conde to LLMs. ])

  #v(5pt)

  #contact(
    phone: "+1 234 567890",
    email: "byte@bfdev.example",
    github: "github.com/byte-overflow",
    location: "Berlin, Germany",
    linkedin: "linkedin.com/in/byte-bf",
  )

  #v(5pt)

  === Languages

  #v(5pt)

  #language("English", "Native", cc: "us")
  #language("German", "C1")
  #language("French", "B2")

  #v(10pt)

  === Core Interests

  #v(5pt)

  #tags(
    "Brainf*ck",
    "Ook!",
    "Esoteric Language Design",
    "Obfuscation Engineering",
    "Compiler Construction",
    "Tape Optimization",
    "Punchcard Stamping",
    "Performance Witchcraft",
  )

  === Programming Languages

  #v(5pt)

  #icon-tags(
    "Bash",
    "Clojure",
    "PHP",
    "COBOL",
    "Erlang",
    "R",
  )

  #v(10pt)

  === Technical Abilities

  #v(5pt)

  #icon-tags(
    "Docker",
    "LLVM",
    "Git",
    "Slack",
    "Latex",
    "SSH",
    "Apache",
    "Emacs",
    "QT",
  )
])

#section("Professional Experience")[

  == Senior Brainfuck Developer
  #small[_NullPointer Innovations • 2021 - present_]
  #v(1pt)
  - Led rewrite of company’s critical microservice into pure Brainfuck;
    achieved 100% fewer dependencies and 300% more questions from management.
  - Designed an advanced Brainfuck code formatter that outputs code
    looking exactly as unreadable as before (backwards compatibility guaranteed).
  - Architected a CI/CD pipeline that refuses to deploy if code is _too readable_.

  == Brainfuck Engineer
  #small[_ObfusCo LLC • 2014 - 2021_]
  #v(1pt)
  - Implemented a Brainfuck-based authentication algorithm;
    auditors refused to review it, thereby improving security dramatically.
  - Introduced team tradition of “Tape Alignment Friday” to improve morale.
]

#section("Education")[

  == M.Sc. Computer Science
  #small[_Technical University of Berlin • 2017_]
  #v(1pt)

  - Thesis: *“Efficient Memory Tape Models for Esoteric Languages”* (Efficiency not guaranteed.)

  == 2014 — B.Sc. Computer Science
  #small[_University of Somewhere • 2014_]
  #v(1pt)
]

#section("Projects & Contributions")[
  - *bf-enterprise™* — The world’s first Brainfuck framework
    with enterprise-grade buzzwords (synergy modules still in beta).
  - *bflint* — A linting tool that warns
    “no human should write this, please reconsider.”
  - Contributor to *Esoterica Standard Library (ESL)* —
    adds high-level abstractions like “loop but on purpose.”
]

#section("Public Speaking")[
  - “Memory-Tape Microservices: A Tragicomedy” — _Berlin Esolang Meetup_
  - “Writing Maintainable Brainfuck (lol)” — _Internal tech talk, resulted in laughter and one resignation._
]
