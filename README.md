This project was created to help answer Stackoverflow question 56135785.
See https://stackoverflow.com/questions/56135785/correctly-set-the-location-of-imported-cmake-targets-for-an-installed-package


It improves the sample code originally submitted by user [bruce-adams](https://stackoverflow.com/users/1569204/bruce-adams),
provides some recommendation to better organize the associated CMake project.


### Suggestions

* Two config files should be generated:
  * one for the build tree: this allow user of your project to directly build against your project and import targets
  * one for the install tree (which also end up being packaged)
* Do not force the value of `CMAKE_INSTALL_PREFIX`
* `CPACK_PACKAGING_INSTALL_PREFIX` should NOT be set to an absolute directory
* For sake of consistency, use `foobarTargets` instead of `foobarLibTargets`
* To allow configuring your project when vendorized along other one, prefer variable with `FOOBAR_`. This means `FOOBAR_INSTALL_LIBRARY_DIR` is better than `LIBRARY_INSTALL_DIR`
* To allow user of the project to configure `*_INSTALL_DIR` variables, wrap them around `if(DEFINED ...)`
* Consistently use variables (e.g `LIBRARY_INSTALL_DIR` should always be used instead of `lib`)
* Prefer naming variable `FOOBAR_INSTALL_*_DIR` instead of `FOOBAR_*_INSTALL_DIR`, it make it easier to know the purpose of the variable when reading the code.
* Since version is already associated with the project, there is no need to set `VERSION` variable. Instead, you can use `PROJECT_VERSION` or `FOOBAR_VERSION`
* If starting a new project, prefer the most recent CMake version. CMake 3.13 instead of CMake 3.7
* Introduced variable `FOOBAR_INSTALL_CONFIG_DIR`
* `foobarTargets.cmake` should not be installed using `install(FILES ...)`,  it is already associated with an install rule
* conditionally set `CMAKE_INSTALL_RPATH`, it is valid only on Linux
* `foobarConfig.cmake.in`:
  * there is no need to set `FOOBAR_LIBRARY`, this information is already associated with the exported `foobar` target
  * FOOBAR_LIBRARY_DIR is also not needed, this information is already associated with the exported `foobar` target
  * instead of setting FOOBAR_INCLUDE_DIR, the command `target_include_directories` should be used
  * remove setting of `FOOBAR_VERSION`, the generate version file already takes care of setting the version.
* always specify ARCHIVE, LIBRARY and RUNTIME when declaring install rules for target. It avoid issue when switching library type. One less thing to think about.
* always specify component with your install rule. It allows user of your project to selectively install part of it only development component or only runtime one, ...
* initializing `CMAKE_BUILD_TYPE` is also important,  it ensures the generated Targets file are associated with a configuration (instead of having the suffix `-noconfig.cmake`)
