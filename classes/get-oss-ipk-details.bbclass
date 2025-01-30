
do_get_ipk_details () {

  BUILD_DIR="tmp/work/element-teone-oss-oe-linux-gnueabi"
  OUTPUT_FILE_NAME="oss_ipk_details.log"
  IPK_DIR="deploy-ipks"

  if [ ! -d "$BUILD_DIR" ]; then
	echo "ERROR: The $BUILD_DIR doesn't exits"
	exit 1
  fi

  echo "" > $OUTPUT_FILE_NAME
  components=`ls $BUILD_DIR | sort`
  for component in $components
  do
	echo "$component"
	ipk_dir=`find $BUILD_DIR/$component -iname "$IPK_DIR" -type d`
	echo "ipk_dir = $ipk_dir"
	if [ -z "$ipk_dir" ];then
		echo "ERROR: The $IPK_DIR is not found for $component"
		#exit 1
		continue
	fi

	recipe_build_dir=`echo $ipk_dir | rev | cut -d '/' -f2 | rev`
	echo "recipe_build_dir = $recipe_build_dir"
	recipe_pv=`echo $recipe_build_dir | cut -d '-' -f1`
	if echo "$recipe_pv" | grep -q '_'; then
               recipe_pv=$(echo "$recipe_pv" | sed 's/^[^_]*_//')
        fi
        recipe_pv=$(echo "$recipe_pv" | sed 's/AUTOINC/0/')
	recipe_pr=`echo $recipe_build_dir | cut -d '-' -f2`
        ipks_name=`find $ipk_dir -iname *.ipk |  sort`
	ipks_list=`find $ipk_dir -iname *.ipk | rev | cut -d '/' -f1 | rev | cut -d '_' -f1 | sort`

	ipk_checksum=""
	for ipk in $ipks_name
	do
		ipk_md5sum=`md5sum $ipk | cut -d " " -f1`
		ipk_sha256sum=`sha256sum $ipk | cut -d " " -f1`
		ipk_name=`echo $ipk | rev | cut -d '/' -f1 | rev | cut -d "_" -f1`
		ipk_checksum="$ipk_checksum $ipk_name.md5sum=$ipk_md5sum $ipk_name.sha256sum=$ipk_sha256sum"

	done
	ipk_checksum=`echo $ipk_checksum | cut -c 1-`

        echo "PV:pn-$component = \"$recipe_pv\"" >> $OUTPUT_FILE_NAME
        echo "PR:pn-$component = \"$recipe_pr\"" >> $OUTPUT_FILE_NAME
        echo "PACKAGE_ARCH:pn-$component = \"\${OSS_LAYER_EXTENSION}\"" >> $OUTPUT_FILE_NAME
        echo "IPK_PACKAGES:pn-$component = \""$ipks_list"\"" >> $OUTPUT_FILE_NAME
        echo "IPK_CHECKSUM:pn-$component = \""$ipk_checksum"\"" >> $OUTPUT_FILE_NAME
        echo "IPK_SRC_BUILD:pn-$component = \"true\"" >> $OUTPUT_FILE_NAME

  done
}

addtask get_ipk_details after do_package_write_ipk before do_build

