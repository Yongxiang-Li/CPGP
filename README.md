# CPGP
Code for our recent paper: Yongxiang Li, Yuting Pu, Changming Cheng, and Qian Xiao. (2023). A Scalable Gaussian Process for Large-Scale Periodic Data. Technometrics. 

------------------------------------------------------------------

Abstract: 
Abstract The periodic Gaussian process (PGP) has been increasingly used to model periodic data due to its high accuracy. Yet, computing the likelihood of PGP has a high computational complexity of \mathcal{O}\left(n^{3}\right) (n is the data size), which hinders its wide application. To address this issue, we propose a novel circulant PGP (CPGP) model for large-scale periodic data collected at grids that are commonly seen in signal processing applications. The proposed CPGP decomposes the log-likelihood of PGP into the sum of two computationally scalable composite log-likelihoods, which do not involve any approximations. Computing the likelihood of CPGP requires only \mathcal{O}\left(p^{2}\right) (or \mathcal{O}\left(p\log p\right) in some special cases) time for grid observations, where the segment length p is independent of and much smaller than n. Simulations and real case studies are presented to show the superiority of CPGP over some state-of-the-art methods, especially for applications requiring periodicity estimation. This new modeling technique can greatly advance the applicability of PGP in many areas and allow the modeling of many previously intractable problems. 

------------------------------------------------------------------

Citation:
If you find our work useful in your research, please consider citing:
@article{li2023scalable,
  title={A scalable Gaussian process for large-scale periodic data},
  author={Li, Yongxiang and Pu, Yuting and Cheng, Changming and Xiao, Qian},
  journal={Technometrics},
  number={just-accepted},
  pages={1--14},
  year={2023},
  url = {http://arxiv.org/abs/2301.01412},
  publisher={Taylor \& Francis}
}

------------------------------------------------------------------

Instructions:
1. Please download and install MATLAB to use this code
2. Add \routine\ as well as \smt\ package to your workpath
3. fit_CPGP.m in the routine package is the main function to fit scalable CPGP model.
4. smt package: a Matlab toolbox for structured matrices.
                    NUMERICAL ALGORITHMS, 59 (2012), pp. 639-659
                    DOI: 10.1007/s11075-011-9527-9.
   this package is used for Toeplitz matrices' fast computation

------------------------------------------------------------------

Notes:
1. The input data for fitting CPGP model is supposed to be grid
2. routine package also contains a comparison method NRCPE.m
3. The results in simulation and real case study can be reproduced by the code in corresponding folders 
4. The raw experimental data are also included (Public dataset like CWRU is not included)



