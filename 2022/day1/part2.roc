app "aoc"
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
    |> Str.split "\n\n"
    |> List.map \load ->
        Str.split load "\n"
        |> List.keepOks Str.toNat

calculateAnswer = \data ->
    data
    |> List.map List.sum
    |> List.walk
        [0, 0, 0]
        \biggestLoads, load ->
            biggestLoads
            |> List.append load
            |> List.sortDesc
            |> List.dropLast

    |> List.sum
    |> Num.toStr
