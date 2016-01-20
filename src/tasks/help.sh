echo ""
echo "${blue}  > ${green}SSH TASKS${reset}"
echo ""
echo "    ssh      send a command to a server"
echo "    help     you're looking at it"
echo ""
echo "${blue}  > ${green}YOUR TASKS${reset}"
echo ""
for t in $TASKS_PATH/tasks/*.sh; do
	t=$(basename $t)
	t=${t%.*}
	echo "    $t"
done
echo ""
exit # required to stop task runner