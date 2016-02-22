echo ""
echo "${blue}  > ${green}ssh-tasks $(cat $TASKS_SRC/VERSION)${reset}"
echo "    ssh"
echo "    version"
echo ""
echo "${blue}  > ${green}tasks${reset}"
for t in $TASKS_PATH/tasks/*.sh; do
	t=$(basename $t)
	t=${t%.*}
	echo "    $t"
done
echo ""
exit 0 # required to stop task runner