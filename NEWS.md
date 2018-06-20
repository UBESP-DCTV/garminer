# garminer 0.0.1

* Added the following **exported** function:
  - `import_monitoring()`: import the *monitoring* data from a (set of) FIT
    file(s) (all of them) into a (same) folder.
* Added the following **not exported** functions:
  - `java_check()` : check if Java is present on the system
  - `java_fit()`   : access to the Java libraries included in the package itself
    to extract raw information from the FIT files
  - `border_date()`: return a minimum or a maximum date depending on the input
  - `adjust_time()`: take the two time-component of a FIT file (`timestamp[s]`
    and `timestamp_16[s]`) and return the correct `POSIXt` R-object computed
    from those two.

# garminer 0.0.0.9000

* Added support for `pipe`
* Added support for roxygen2 
* Added support for testthat
* Added badges to `README`
* Added CodeCov support
* Added Appveyor support
* Added Travis-CI support
* Added a `NEWS.md` file to track changes to the package.
