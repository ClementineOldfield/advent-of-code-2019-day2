defmodule IntcodeProgram do
  @moduledoc """
  Documentation for IntcodeProgram.
  """

  defp check_values_exist(list, value_index_1, value_index_2) do
    value_1 = Enum.at(list, value_index_1)
    value_2 = Enum.at(list, value_index_2)

    if value_1 != nil && value_2 != nil do
      {:ok, value_1, value_2}
    else
      {:error, :bad_instructions}
    end
  end

  def do_opcode(list, [1, value_1, value_2, replace_at_index]) do
    List.replace_at(list, replace_at_index, value_1 + value_2)
  end

  def do_opcode(list, [2, value_1, value_2, replace_at_index]) do
    List.replace_at(list, replace_at_index, value_1 * value_2)
  end

  def process_opcodes(int_list), do: process_opcodes(int_list, int_list)

  def process_opcodes([99 | _], int_list), do: int_list

  def process_opcodes([code, i_1, i_2, p | t], int_list) do
    case check_values_exist(int_list, i_1, i_2) do
      {:ok, value_1, value_2} ->
        new_list = do_opcode(int_list, [code, value_1, value_2, p])
        opcodes = Enum.take(new_list, -1 * length(t))
        process_opcodes(opcodes, new_list)

      {:error, error} ->
        {:error, error}
    end
  end

  def possible_noun_verb_combinations(length) do
    for n <- 0..(length - 1), v <- 0..(length - 1), do: {n, v}
  end

  def noun_and_verb_for_result(int_list, target) do
    combinations = possible_noun_verb_combinations(length(int_list))
    noun_and_verb_for_result(int_list, target, combinations)
  end

  def noun_and_verb_for_result(_, _, []), do: {:error, :not_found}

  def noun_and_verb_for_result(int_list, target, [{n, v} | t]) do
    list =
      int_list
      |> List.replace_at(1, n)
      |> List.replace_at(2, v)

    case process_opcodes(list) do
      [^target | _] ->
        {n, v}

      _ ->
        noun_and_verb_for_result(int_list, target, t)
    end
  end

  @int_list [
    1,
    0,
    0,
    3,
    1,
    1,
    2,
    3,
    1,
    3,
    4,
    3,
    1,
    5,
    0,
    3,
    2,
    10,
    1,
    19,
    1,
    19,
    9,
    23,
    1,
    23,
    6,
    27,
    1,
    9,
    27,
    31,
    1,
    31,
    10,
    35,
    2,
    13,
    35,
    39,
    1,
    39,
    10,
    43,
    1,
    43,
    9,
    47,
    1,
    47,
    13,
    51,
    1,
    51,
    13,
    55,
    2,
    55,
    6,
    59,
    1,
    59,
    5,
    63,
    2,
    10,
    63,
    67,
    1,
    67,
    9,
    71,
    1,
    71,
    13,
    75,
    1,
    6,
    75,
    79,
    1,
    10,
    79,
    83,
    2,
    9,
    83,
    87,
    1,
    87,
    5,
    91,
    2,
    91,
    9,
    95,
    1,
    6,
    95,
    99,
    1,
    99,
    5,
    103,
    2,
    103,
    10,
    107,
    1,
    107,
    6,
    111,
    2,
    9,
    111,
    115,
    2,
    9,
    115,
    119,
    2,
    13,
    119,
    123,
    1,
    123,
    9,
    127,
    1,
    5,
    127,
    131,
    1,
    131,
    2,
    135,
    1,
    135,
    6,
    0,
    99,
    2,
    0,
    14,
    0
  ]

  def given_values do
    @int_list
  end

  def result_1 do
    list =
      @int_list
      |> List.replace_at(1, 12)
      |> List.replace_at(2, 2)

    process_opcodes(list)
  end

  def result_2 do
    noun_and_verb_for_result(@int_list, 19_690_720)
  end
end
