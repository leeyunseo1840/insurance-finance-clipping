# 보험·금융 뉴스 클리핑 — 무료 운영

Render Static Site + GitHub Actions로 운영합니다. 유료 서버, 데이터베이스, 디스크, Cron Job, AI API는 필요하지 않습니다.

## Render 설정
- GitHub 저장소: leeyunseo1840/insurance-finance-clipping (main)
- 서비스 종류: **Static Site**
- Build Command: `bash build-static.sh`
- Publish Directory: `app-source/dist-render`
- Auto Deploy: On Commit
- 환경변수/API 키: 기본 RSS 수집에는 필요 없음
- 기존 Web Service는 이 설정과 별개입니다. 유료 플랜을 선택하지 마세요.

## 매일 업데이트
`.github/workflows/daily.yml`이 한국시간 매일 오전 07:17에 예약됩니다. GitHub 예약 실행은 지연될 수 있으며 정확한 시각을 보장하지 않습니다. Actions 탭 → Daily free clipping → Run workflow로 즉시 실행할 수도 있습니다.

RSS 수집 → 48시간 범위 선별 → 유사 제목 클러스터링 → 중요도 정렬 → JSON 파일 저장 → GitHub 커밋 → Render 자동 배포 순서입니다. 공개 저장소의 표준 GitHub Actions 실행 환경과 Render 무료 Static Site 범위로 구성합니다. 사용량 정책은 각 서비스에서 확인하세요.

수집이 실패하면 기존 파일을 덮어쓰지 않습니다. 사이트는 마지막 성공 수집 시각을 표시합니다. 오래된 수집 시각은 오늘 날짜로 바꾸지 않습니다. `data/YYYY-MM-DD.json`은 날짜별 기록입니다. 최초 배포에는 source.tar.gz 안의 2026-09-11 수집본이 포함되어 있습니다.

## 무료 요약의 범위
유료 AI를 사용하지 않으므로 요약은 공개 피드 발췌입니다. 공식 사실 검증과 사건일·시행일 확인은 자동으로 완료되었다고 주장하지 않습니다. 검증 자료가 있는 수동 리뷰만 사실/해석/시행일을 구분해 제공합니다. 보도량은 수집된 피드 안에서만 비교합니다. 기사 원문 링크를 함께 표시하며 원문 전체는 저장하지 않습니다.

## 소스 수정
소스는 `source.tar.gz`에 있습니다. 압축을 풀고 수정한 뒤 같은 구조로 다시 압축해 올립니다. `build-static.sh`는 소스를 풀고 `npm ci` 및 정적 빌드를 실행합니다. `VITE_STATIC_NEWS=true`가 빌드에 설정됩니다. 무료판은 `/api/news` 서버 대신 `/data/latest.json`을 읽습니다.

수집 피드: `config/feeds.json`. 검증 리뷰: `config/reviews.json`. 수집기: `scripts/collect.py`. 정적 파일 생성: `scripts/export-static.py`. 선택적 네이버 검색 API는 수집기에 NAVER_CLIENT_ID/NAVER_CLIENT_SECRET 환경변수를 전달하는 방식이며 기본 workflow에는 사용하지 않습니다. 키를 저장소에 올리지 마세요.

## 확인
배포 후 `/data/latest.json`의 edition.date, collectedAt 및 items를 확인하고 홈페이지 원문 링크와 날짜 필터를 확인합니다. 뉴스 수집 성공과 Render 배포 성공은 각각 Actions / Render Events에서 확인합니다.
