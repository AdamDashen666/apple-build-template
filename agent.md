# Agent handoff

## 目标
在 Windows 上通过 GitHub Actions（macOS runner）编译、测试、打包 iOS/iPadOS/macOS App。本目录是模板仓库 `apple-build-template`（公开、设为 GitHub template），每个新 App 从它创建独立仓库。全局技能 `C:\Users\Admin\.claude\skills\apple-build\SKILL.md` 记录了以后的完整流程。

## 关键文件
- `project.yml`：XcodeGen 配置（CI 上生成 .xcodeproj），两个 App target + 两个测试 target。
- `.github/workflows/build.yml`：iOS job（模拟器单测 → iPhone/iPad 截图 → 未签名 IPA → 有 Secrets 时重签）、macOS job（单测 → universal Release → zip/dmg → 启动截图）。
- `scripts/resign-ipa.sh`：用 p12 + mobileprovision 重签；`scripts/set-signing-secrets.ps1`：用户本人上传签名 Secrets；`scripts/ci-run.sh`：推送、等构建、下载产物到 out/<run_id>/。

## 当前状态
- 已推送到 https://github.com/AdamDashen666/apple-build-template（公开，已设为 template）。
- CI 已验证通过（run 38890325660）：iOS/macOS 单测通过，iPhone/iPad/macOS 截图正常，产出 unsigned IPA、macOS zip/dmg。iOS job 约 10 分钟，macOS 约 2 分钟。
- 签名重签路径（resign-ipa.sh）尚未实测：用户还没运行 set-signing-secrets.ps1 上传证书。
- actions/upload-artifact@v5 仍报 Node 20 弃用警告（无害），可升到 v6。

## 下一步
- 用户上传签名 Secrets 后跑一次构建，验证 *-signed.ipa 能装到其 iPhone。
- 新 App 按全局技能 apple-build 的流程从模板创建。
