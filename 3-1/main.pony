use "files"

actor Main
  new create(env: Env) =>
    try
      let path = FilePath(env.root as AmbientAuth, "input")?
      match OpenFile(path)
      | let file: File =>
        let ones = Array[U64].init(0, 12)
        var total: U64 = 0
        for line in file.lines() do
          let line' = consume val line
          var i: USize = 0
          while i < ones.size() do
            if line'(i)? == '0' then
              ones(i)? = ones(i)? + 1
            end
            i = i + 1
          end
          total = total + 1
        end
        var gamma = ""
        var epsilon = ""
        for x in ones.values() do
          if x > (total / 2) then
            gamma = gamma + "1"
            epsilon = epsilon + "0"
          else
            gamma = gamma + "0"
            epsilon = epsilon + "1"
          end
        end
        env.out.print((gamma.u64(2)? * epsilon.u64(2)?).string())
      else
        env.err.print("Error opening input file ")
      end
    end