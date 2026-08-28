#!/bin/bash
# drop in* 確認用サイトを更新して公開する
# 使い方: ./deploy.sh  （クリーン版HTMLを取り込んで push）
set -e
CLEAN="/Users/kudotakeshi/Dropbox/【★★クライアント】/【モニター案件】/ドロップin　伊福さん/dropin_site_伊福さん確認用.html"
cd "$(dirname "$0")"
python3 - "$CLEAN" <<'PY'
import sys
s=open(sys.argv[1],encoding='utf-8').read()
i=s.index('</style>')+len('</style>')
head,body=s[:i],s[i:]
doc=('<!doctype html>\n<html lang="ja">\n<head>\n'
 '<meta charset="utf-8">\n'
 '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
 '<meta name="robots" content="noindex,nofollow,noarchive,nosnippet">\n'
 '<meta name="description" content="組織改善3か月調律プログラム">\n'
 + head + '\n</head>\n<body>\n' + body + '\n</body>\n</html>\n')
open('index.html','w',encoding='utf-8').write(doc)
print('index.html updated:', len(doc)//1024, 'KB')
PY
git add -A
git commit -q -m "Update preview" || { echo "変更なし"; exit 0; }
git push -q
echo "公開しました → https://taketkg.github.io/dropin-review-9d4c2a/"
