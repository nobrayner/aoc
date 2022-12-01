app "helloWorld"
    packages { pf: "cli/cli-platform/main.roc" }
    imports [
      pf.Stdout,
      pf.Task.{ Task },
      pf.File,
      pf.Path.{ Path },
      pf.Process,
    ]
    provides [main] to pf

main =
  task =
    input <- File.readUtf8 (Path.fromStr "input.txt") |> Task.await
    parsedInput = parseInput input
    answer = calculateAnswer parsedInput
    Stdout.line answer

  Task.attempt task \result ->
    when result is
      Ok {} -> Process.exit 0
      Err _ -> Process.exit 1

parseInput = \input ->
  input

calculateAnswer = \data ->
  data
