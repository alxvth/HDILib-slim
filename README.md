# HDILib: High Dimensional Inspector Library

Slimmed-down fork of [HDILib](https://github.com/biovault/HDILib): mainly no external dependencies like FLANN, that have to be compiled.
To be compatible with the HDILib, you may want to include [nanoflann](https://github.com/jlblancoc/nanoflann), which is already present in `hdi/data/nano_flann.h`.

HDILib is a library for the scalable analysis of large and high-dimensional data.
It contains scalable manifold-learning algorithms, visualizations and visual-analytics frameworks.
HDILib is implemented in C++, OpenGL and JavaScript.
It is developed within a joint collaboration between the [Computer Graphics & Visualization](https://graphics.tudelft.nl/) group at the [Delft University of Technology](https://www.tudelft.nl) and the [Division of Image Processing (LKEB)](https://www.lumc.nl/org/radiologie/research/LKEB/) at the [Leiden Medical Center](https://www.lumc.nl/).

## Authors
- [Nicola Pezzotti](http://nicola17.github.io/) initiated the HDI project, developed the A-tSNE and HSNE algorithms and implemented most of the visualizations and frameworks.
- [Thomas Höllt](https://www.thomashollt.com/) ported the library to MacOS.

## Used
HDI is used in the following projects:
- [Cytosplore](https://www.cytosplore.org/): interactive system for understanding how the immune system works
- [Brainscope](http://www.brainscope.nl/brainscope): web portal for fast,
interactive visual exploration of the [Allen Atlases](http://www.brain-map.org/) of the adult and developing human brain
transcriptome
- [DeepEyes](https://graphics.tudelft.nl/Publications-new/2018/PHVLEV18/): progressive analytics system for designing deep neural networks

## Reference
Reference to cite when you use HDI in a research paper:

```
@inproceedings{Pezzotti2016HSNE,
  title={Hierarchical stochastic neighbor embedding},
  author={Pezzotti, Nicola and H{\"o}llt, Thomas and Lelieveldt, Boudewijn PF and Eisemann, Elmar and Vilanova, Anna},
  journal={Computer Graphics Forum},
  volume={35},
  number={3},
  pages={21--30},
  year={2016}
}
@article{Pezzotti2017AtSNE,
  title={Approximated and user steerable tsne for progressive visual analytics},
  author={Pezzotti, Nicola and Lelieveldt, Boudewijn PF and van der Maaten, Laurens and H{\"o}llt, Thomas and Eisemann, Elmar and Vilanova, Anna},
  journal={IEEE transactions on visualization and computer graphics},
  volume={23},
  number={7},
  pages={1739--1752},
  year={2017}
}
```

## Building

### GIT Cloning 
When cloning the repo be aware that it includes submodules. With the latest git versions you should use the following command:

```
git clone --recurse-submodules https://github.com/alxvth/HDILibSlim.git
```

### Dependencies

- [Eigen 3.4](https://gitlab.com/libeigen/eigen/)

### Ubuntu

On **Ubuntu 16.04** you can build and install HDI by running the following commands

```bash
./scripts/install-dependencies.sh
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=Release ..
make -j 8
sudo make install
```

### Windows

On **Windows** use CMake and set a `custom_install_path`

```
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="custom_install_path"
```


## Applications

A suite of command line and visualization applications is available in the [original High Dimensional Inspector](https://github.com/biovault/High-Dimensional-Inspector) repository.


