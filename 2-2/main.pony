use "files"

actor Main
  new create(env: Env) =>
    try
      let path = FilePath(env.root as AmbientAuth, "input")?
      match OpenFile(path)
      | let file: File =>
        var aim: U64 = 0
        var x: U64 = 0
        var depth: U64 = 0
        for line in file.lines() do
          let line' = consume val line
          let split = line'.split(" ")
          let command = split(0)?
          let value = split(1)?.u64()?
          if command == "forward" then
            x = x + value
            depth = depth + (aim * value)
          elseif command == "down" then
            aim = aim + value
          else
            aim = aim - value
          end
        end
        env.out.print((depth * x).string())
      else
        env.err.print("Error opening input file ")
      end
    end