#############################################################
#                                                           #
#  Amin Ghasemazar                                          #
#  March 2020                                               #
#  For more info: aming@ece.ubc.ca                          #
#                                                           #
#############################################################

# An easy way to create a random subset of ImageNet for rapid testings.
# If interested in more advanced version (i.e. Animals only etc.), check out:
# https://robustness.readthedocs.io/en/latest/example_usage/custom_imagenet.html

srcFolder=/data/IMAGENET-UNCROPPED
dstFolder=/data/IMAGENET-UNCROPPED-SAMPLED


# Copy N=500 random images from each class to the destination
for f in $srcFolder/*
do
    mkdir -p $dstFolder/$(basename $f)
    for sub_f in $f/*
    do
        mkdir -p $dstFolder/$(basename $f)/$(basename $sub_f)
        shuf -zn500 -e $sub_f/* | xargs -0 cp -vt $dstFolder/$(basename $f)/$(basename $sub_f)/ # keeping 500 iamges
    done
done


# Randomly removing M=950 classes from the total 1000 classes
for i in {1..950} # keeping 50 classes
do
    echo $i
    fldr=$(ls /data/IMAGENET-UNCROPPED-SAMPLED/train/ | shuf | tail -1 )
    rm -rf $dstFolder/train/$fldr
    rm -rf $dstFolder/val/$fldr
done
