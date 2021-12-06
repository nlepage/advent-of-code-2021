use "files"

actor Main
  new create(env: Env) =>
    try
      let path = FilePath(env.root as AmbientAuth, "input")?
      match OpenFile(path)
      | let file: File =>
        var prev: U64 = U64.max_value()
        var increased_count: U64 = 0
        for line in file.lines() do
          let line' = consume val line
          let depth = line'.u64()?
          if depth > prev then
            increased_count = increased_count + 1
          end
          prev = depth
        end
        env.out.print(increased_count.string())
      else
        env.err.print("Error opening input file ")
      end
    end