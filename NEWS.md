# nzpullover 0.3.0

* Updated with data up to December 2017 (the September quarter was skipped by
    the NZ Police).
* Updated the code for the latest version of `tidyxl`.

# nzpullover 0.2.0

* Updated with data up to June 2017.
* Added the `police_speeding_band` dataset, which was being imported but not
  being published.

# nzpullover 0.1.0

* Updated with data up to March 2017.
* Trimmed the `speed` character variable in the `excess` dataset, e.g. ` 11-15` is
  now `11-15`.
* Encoded UTF-8 strings that now appear in the source data as UTF-8, using the
  development version of [`tidyxl`](https://github.com/nacnudus/tidyxl).  Note
  that the source data has changed the spelling of some terms, from `mcg` to
  `µg`:
    - `Lowered adult alcohol limit (250µg breath / 50mg  blood) offences    (note: these figures are also included in the 'Alcohol specific offences' table above)`
    - `Lowered adult alcohol limit (250µg breath / 50mg blood) monetary amount  (note: these figures are also included in the 'Alcohol specific monetary amount' table above)`
    - `Under 20 zero alcohol limit (0µg breath / 0mg blood) offences    (note: these figures are also included in the 'Alcohol specific offences' table above)`
    - `Under 20 zero alcohol limit (0µg breath / 0mg blood) monetary amount  (note: these figures are also included in the 'Alcohol specific monetary amount' table above)`

# nzpullover 0.0.3

* Updated with data up to December 2016.
* Added a `NEWS.md` file to track changes to the package.
