# 보험·금융·경제 클리핑

GA 마케터가 설계사와 고객에게 유익한 콘텐츠 소재를 찾는 뉴스 사이트입니다.

## 현재 상태
- 화면 및 RSS 수집기 구현. 공개 배포와 정기 실행 연결은 아직 필요합니다.
- 상단 요약·복습 일부와 검증 해설은 2026-09-09 자료에 맞춘 편집본입니다. 자동 수집만으로 이 부분까지 당일 해설로 갱신되지는 않습니다. 운영 전 데이터 기반 생성으로 바꿔야 합니다.
- RSS 기사는 공식 발표와 별도로 대조하기 전까지 확인 필요로 표시합니다.

## 실행
Node.js 24와 Python 3.12를 사용합니다.

```sh
npm ci
npm run build:render
npm run start:render
```

사이트는 기본적으로 3000번 포트에서 실행됩니다.

## 뉴스 수집
```sh
python scripts/collect.py
node scripts/import-local.mjs
```

공식 RSS 목록은 config/feeds.json, 검증 해설은 config/reviews.json, 과거 배경 이슈는 config/background.json에 있습니다. 수집 실패 시 이전 자료를 보존합니다.

## Render 배포
Dockerfile로 Web Service를 생성합니다. DATA_DIR=/var/data로 설정하고 해당 위치에 영구 디스크를 연결해야 재시작 후 아카이브가 유지됩니다. render.yaml은 Web Service와 Cron Job 예시이며 유료 서비스가 포함됩니다.

기존 사이트를 교체할 때는 먼저 Render의 저장소 연결과 배포 설정을 확인합니다.

## 환경변수
- CLIPPING_IMPORT_TOKEN: 최소 32자 무작위 비밀값. 웹 서버와 수집 작업에 같은 값 설정.
- CLIPPING_IMPORT_URL: 공개 사이트의 https://도메인/api/import 주소.
- NAVER_CLIENT_ID / NAVER_CLIENT_SECRET: 선택. 네이버 개발자센터에서 검색 API를 활성화한 앱의 값. 없으면 RSS만 사용.
- DATA_DIR: Render의 영구 디스크 경로.

비밀값은 GitHub Actions Secrets 또는 Render Environment에만 저장하세요. 저장소에 올리지 않습니다.

## 매일 자동 수집
.github/workflows/daily.yml은 매일 한국시간 오전 7시 17분 실행 요청입니다. GitHub 스케줄은 지연될 수 있습니다. 저장소 기본 브랜치에 파일을 올리고 Actions를 활성화한 뒤 위 Secrets를 설정합니다. 첫 실행은 Run workflow로 확인합니다.

Render Cron Job을 사용할 때도 같은 환경변수를 설정합니다. 두 스케줄러 중 하나만 사용하세요. Cron Job은 웹 서버의 디스크를 공유하지 않고 /api/import로 결과를 전달합니다.

## 편집 원칙
한국시간 수집 기준, 게시일과 사건일 구분, 핵심 사실 옆 근거 링크, 사실과 해석 분리. 미확인 정보는 추측하지 않습니다. 보험뿐 아니라 금융·경제 전반의 고객 효용을 기준으로 선정합니다.

## 저장소 파일 구조
브라우저 업로드를 위해 전체 소스가 source.tar.gz에 담겨 있습니다. 루트 Dockerfile이 소스를 풀어 설치·빌드합니다. 로컬 수정 시 압축을 풀고 작업하세요. GitHub Actions 사용 시 압축 내부 .github/workflows/daily.yml을 저장소에 별도로 등록하고 수집 전에 소스를 풀어야 합니다. Render Cron을 선택하면 Docker에서 압축이 자동 해제됩니다.

