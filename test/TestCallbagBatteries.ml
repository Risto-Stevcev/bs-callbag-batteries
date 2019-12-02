open BsMocha
let describe, it = Mocha.(describe, it);;


describe "CallbagBatteries" (fun () -> begin
  let open CallbagBatteries in
  describe "spread" (fun () -> begin
    it "should spread the values" (fun () -> begin
      let arr = [|[|1;2;3|]; [|4;5;6|]|] in
      let expected =
        Js.Array.concatMany arr [||]
      and actual =
        from_array arr
        |> spread
        |> to_array
      in
      Assert.deep_equal expected actual
    end)
  end);


  describe "only_some" (fun () -> begin
    it "should return stream with only existing values" (fun () ->
      let arr =
        [|Some `foo; Some `bar; None; Some `baz; None|] in
      let expected =
        [|`foo; `bar; `baz|]
      and actual =
        from_array arr
        |> only_some
        |> to_array
      in
      Assert.deep_equal expected actual
    )
  end);


  describe "spread_last" (fun () -> begin
    it "should return a stream where the last signal (array) is spread as a stream of signals"
      (fun () -> begin
        let arr =
          [|[|1;2;3|]; [|4;5|]; [|6;7;8|]|] in
        let expected =
          [|6;7;8|]
        and actual =
          from_array arr
          |> spread_last
          |> to_array
        in
        Assert.deep_equal expected actual
      end)
  end);
end);
