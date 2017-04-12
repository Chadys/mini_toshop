fox_files=(*.png)
demo_files=(../demo/*.png)

for ((i=0;i<=${#fox_files[@]};i++)); do
   mv ${demo_files[i]} ../demo/${fox_files[i]}
done