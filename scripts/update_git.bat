@echo off
SET /P msg=[Digite a mensagem do commit]

echo -
echo ----------------------------
echo --- Salvando Alteracoes ----
echo ----------------------------
echo -
cd /AppSamosMVC/
git add .
git commit -m "%msg%"

echo -
echo ----------------------------
echo --- Subindo Alteracoes ----
echo ----------------------------
echo -
git push origin master


echo -
echo ----------------------------
echo ---------- Pronto ----------
echo ----------------------------
echo -

pause