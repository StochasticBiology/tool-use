tail -n1 ../total-observations.txt-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-total.txt

tail -n1 ../sample-observations-0.1-1-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-1.txt
tail -n1 ../sample-observations-0.1-2-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-2.txt
tail -n1 ../sample-observations-0.1-3-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.1-3.txt

tail -n1 ../sample-observations-0.2-1-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-1.txt
tail -n1 ../sample-observations-0.2-2-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-2.txt
tail -n1 ../sample-observations-0.2-3-trans.txt-posterior-0-1-3-5.txt.process | sed 's/#//g' | sed 's/)//g' | sed 's/,/\n/g' | sed 's/feature_//g' > means-sample-0.2-3.txt
