# Load drug signatures and corresponding metadata
sigs = LoadCDSigs()
info = LoadCDInfo()

# Construct large tensor
out = ConstructTensor(sigs=sigs, info=info, pThresh=0.1, specificDose=FALSE, time='all',
                      print=TRUE, nPerDrug=3, nPerCell=3, removeDuplicates=TRUE)

# define 4 tensors (only use two of them in the final PSB paper)
tensors = list()
tensors$large = out$tensor
tensors$manycell = SubsetTensor(out$tensor, nDrugs=300, nCells=50)
tensors$manydrug = SubsetTensor(out$tensor, nDrugs=2000, nCells=15)
tensors$small = out$tensor[dimnames(tensors$manycell)[[1]],,dimnames(tensors$manydrug)[[3]]] 

# save to mat files
WriteTensor2Mat(tensors$small, file=DataDir('tensors/small.mat'))
WriteTensor2Mat(tensors$large, file=DataDir('tensors/large.mat'))
