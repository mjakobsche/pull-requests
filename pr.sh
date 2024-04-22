BASE_BRANCH="${1}"
AMOUNT=$2
CHANGED_FILE="changes.txt"
COUNTER=1
while [ $COUNTER -lt $AMOUNT ]
do
    CHANGE=$(date)
    PR_BRANCH="${BASE_BRANCH}-${COUNTER}"
    git checkout $BASE_BRANCH
    git pull
    sleep 3
    git branch "${PR_BRANCH}"    
    git checkout "${PR_BRANCH}"    
    echo "${CHANGE}" > "${CHANGED_FILE}"
    git add "${CHANGED_FILE}"
    git commit -am "iteration ${COUNTER}"
    git push -u origin "${PR_BRANCH}"
    gh pr create --title "pr no. ($COUNTER)" --body "appended ${CHANGE} to ${CHANGED_FILE}"
    ((COUNTER++))
done
