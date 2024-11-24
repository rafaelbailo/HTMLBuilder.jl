(
  "another_folder/another_path",
  HTMLDoc(
    DOCTYPE(),
    html(
      (; lang = "en"),
      head(title("Page with Custom Path")),
      body(
        h1("Page with Custom Path"),
        p("The path of this page was configured manually."),
      ),
    ),
  ),
)
