# gets the mean inferred acquisition ordering for each feature from a subset of posterior analyses

# these are output by posteriors.c so this script rather messily extracts the corresponding quantities and removes annotations

tail -n1 ../total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-total.txt

tail -n1 ../sample-observations-0.1-1.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-1.txt
tail -n1 ../sample-observations-0.1-2.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-2.txt
tail -n1 ../sample-observations-0.1-3.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-3.txt
tail -n1 ../sample-observations-0.1-4.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-4.txt
tail -n1 ../sample-observations-0.1-5.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-5.txt
tail -n1 ../sample-observations-0.1-6.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-6.txt

tail -n1 ../sample-observations-0.2-1.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-1.txt
tail -n1 ../sample-observations-0.2-2.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-2.txt
tail -n1 ../sample-observations-0.2-3.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-3.txt
tail -n1 ../sample-observations-0.2-4.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-4.txt
tail -n1 ../sample-observations-0.2-5.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-5.txt
tail -n1 ../sample-observations-0.2-6.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-6.txt

