include CallbagBasics
let to_array = CallbagToArray.to_array
let to_promise = CallbagToPromise.to_promise
let from_readline = CallbagFromReadline.from_readline
let last = CallbagLast.last


(** Converts a stream of arrays of x into a stream of x *)
let spread stream =
  stream
  |> map from_array
  |> flatten


(** Returns a stream with only existing values *)
let only_some stream =
  stream
  |> filter Js.Option.isSome
  |> map Js.Option.getExn


(** Spreads only the last item of the stream before closing *)
let spread_last stream =
  stream
  |> last
  |> spread
