defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> mirror_row
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row
    # [145, 46, 200, 46, 145]

    # ++ joins list together
    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
    # %Identicon.Image{hex: hex_list} = image
    # [red, green, blue | _tail] = hex_list
    # %Identicon.Image{hex: [red, green, blue | _tail]} = image

    # [red, green, blue]
    # don't modify existing data, create new obj
    %Identicon.Image{image | color: {red, green, blue}}
  end



  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    # always produces a list of numbers

    %Identicon.Image{hex: hex}
  end
end
