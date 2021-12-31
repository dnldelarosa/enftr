# Zona de residencia

    Code
      ft_zona(enft1)
    Output
        PERIALFA S1_P4 zona
      1        1     0    1
      2        2     1    2

---

    Code
      ft_zona(enft2)
    Output
        EFT_PERIODO EFT_ZONA zona
      1           1        0    1
      2           2        1    2

---

    Code
      ft_compute_zona(enft2)
    Warning <lifecycle_warning_deprecated>
      `ft_compute_zona()` was deprecated in enftr 0.1.0.
      Please use `ft_zona()` instead.
    Output
        EFT_PERIODO EFT_ZONA zona
      1           1        0    1
      2           2        1    2

