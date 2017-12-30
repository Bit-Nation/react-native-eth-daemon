cd ios/Frameworks
cp -RP Geth.Framework tmp
cd Geth.Framework

links="Headers Resources Modules Geth"

for link in $links ; 
do
	resolvedLink=`readlink $link`
	if [[ ! -z $resolvedLink ]] ; 
	then
		rm $link
		mv -v $resolvedLink .
	fi
done

rm -rf Versions