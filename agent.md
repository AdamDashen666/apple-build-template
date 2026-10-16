# Agent handoff

## 目标
在 Windows 上通过 GitHub Actions（macOS runner）编译、测试、打包 iOS/iPadOS/macOS App。本目录是模板仓库 `apple-build-template`（公开、设为 GitHub template），每个新 App 从它创建独立仓库。全局技能 `C:\Users\Admin\.claude\skills\apple-build\SKILL.md` 记录了以后的完整流程。

## 关键文件
- `project.yml`：XcodeGen 配置（CI 上生成 .xcodeproj），两个 App target + 两个测试 target。
- `.github/workflows/build.yml`：iOS job（模拟器单测 → iPhone/iPad 截图 → 未签名 IPA → 有 Secrets 时重签）、macOS job（单测 → universal Release → zip/dmg → 启动截图）。
- `scripts/resign-ipa.sh`：用 p12 + mobileprovision 重签；`scripts/set-signing-secrets.ps1`：用户本人上传签名 Secrets；`scripts/ci-run.sh`：推送、等构建、下载产物到 out/<run_id>/。

## 当前状态
- 文件已写好并在本地提交；尚未推送到 GitHub，也尚未在 CI 上验证过（需要用户先完成 `gh auth login`）。
- 用户尚未上传签名 Secrets。

## 下一步
1. 用户登录后：`gh repo create apple-build-template --public --source . --push`，`gh repo edit --template`。
2. 跑 `bash scripts/ci-run.sh`，修到 iOS 和 macOS 两个 job 都通过，查看截图。
3. 用户运行 set-signing-secrets.ps1 后再验证 signed IPA。
