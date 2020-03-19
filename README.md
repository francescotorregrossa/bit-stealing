> Developed with [Giuseppe Marino](https://github.com/giuseppe16180)

## Bit stealing

Given an RGB image, calculates its luma value Y (from [YUV](https://en.wikipedia.org/wiki/YUV)) as follows

```matlab
Y = R .* 0.2989 + G .* 0.587 + B .* 0.114;
```

and then associates its level with the closest gray (or almost gray) color that you can produce, `[y+r, y, y+b]`, where `y` is a rounded from `Y`, and `r` and `b` usually lie in the range of `[-1, 1]` and `[-2, 2]` (integers).

An approximate solution can be obtained by using a pre calculated look up table, indexed by the luma level in ascending order. This is similar to what is described in the [bit stealing paper](https://www.researchgate.net/publication/253451407_Bit_stealing_How_to_get_1786_or_more_gray_levels_from_an_8-bit_color_monitor), although the look up table is slightly different.

### Usage

The `bitstealing` function requires two parameters and outputs the grayscale image.

```matlab
out = bitstealing(img, l);
```

- `img` is the RGB image
- `l` is the *level of variation* allowed, which can be either
  - `1`, which makes `b = [-1, 1]`, where colors are closer to pure gray (766 shades available)
  - `2`, which makes `b = [-2, 2]` (1274 shades available)
  - `3`, which makes `b = [-1, 1]` and `r = [-1, 1]` (2294 shades available)
  - `4`, which makes `b = [-2, 2]` and `r = [-1, 1]`, where colors can be further from pure gray (3816 shades available)
