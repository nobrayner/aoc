app "helloWorld"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
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
  |> Str.split "\n"
  |> List.map \line -> line |> Str.split " "

calculateAnswer = \data ->
  data
  |> List.map \match ->
    when match is
      ["A", "X"] -> 4
      ["A", "Y"] -> 8
      ["A", "Z"] -> 3
      ["B", "X"] -> 1
      ["B", "Y"] -> 5
      ["B", "Z"] -> 9
      ["C", "X"] -> 7
      ["C", "Y"] -> 2
      ["C", "Z"] -> 6
      _ -> 0
  |> List.sum
  |> Num.toStr
