defmodule IntcodeProgramTest do
  use ExUnit.Case
  # doctest IntcodeProgram

  @small_list [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]

  test "processes an intlist" do
    assert IntcodeProgram.process_opcodes(@small_list) == [
             3500,
             9,
             10,
             70,
             2,
             3,
             11,
             0,
             99,
             30,
             40,
             50
           ]
  end

  test "processes an intlist example 2" do
    assert IntcodeProgram.process_opcodes([1, 0, 0, 0, 99]) ==
             [2, 0, 0, 0, 99]
  end

  test "processes an intlist example 3" do
    assert IntcodeProgram.process_opcodes([2, 3, 0, 3, 99]) ==
             [2, 3, 0, 6, 99]
  end

  test "processes an intlist example 4" do
    assert IntcodeProgram.process_opcodes([2, 4, 4, 5, 99, 0]) ==
             [2, 4, 4, 5, 99, 9801]
  end

  test "processes an intlist example 5" do
    assert IntcodeProgram.process_opcodes([1, 1, 1, 4, 99, 5, 6, 0, 99]) ==
             [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end

  @int_list [2, 7, 2, 4, 50, 4, 2, 1, 1, 14, 2, 8, 1, 4, 9, 10, 99]
  @expected [2, 4, 2, 4, 2, 4, 2, 1, 11, 14, 16, 8, 1, 4, 9, 10, 99]

  test "processes a long intlist" do
    assert IntcodeProgram.process_opcodes(@int_list) == @expected
  end

  test "finds correct noun and verb for list" do
    assert IntcodeProgram.noun_and_verb_for_result(IntcodeProgram.given_values(), 4_138_658) ==
             {12, 2}
  end

  test "result" do
    # IO.inspect(IntcodeProgram.result_2())
  end
end
