use "files"

actor Main
  new create(env: Env) =>
    try
      let path = FilePath(env.root as AmbientAuth, "input")?
      match OpenFile(path)
      | let file: File =>
        var x: U64 = 0
        var depth: U64 = 0
        for line in file.lines() do
          let line' = consume val line
          let split = line'.split(" ")
          if split(0)? == "forward" then
            x = x + split(1)?.u64()?
          elseif split(0)? == "down" then
            depth = depth + split(1)?.u64()?
          else
            depth = depth - split(1)?.u64()?
          end
        end
        env.out.print((depth * x).string())
      else
        env.err.print("Error opening input file ")
      end
    end