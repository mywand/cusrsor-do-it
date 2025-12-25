# 规约文件重组脚本
$rulesPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# 创建分类目录
$directories = @('core', 'coding', 'architecture', 'frontend', 'practices', 'documentation', 'misc')
foreach ($dir in $directories) {
    $dirPath = Join-Path $rulesPath $dir
    if (-not (Test-Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
        Write-Host "创建目录: $dir"
    }
}

# 定义文件分类映射
$fileMapping = @{
    'core' = @('must.mdc', 'role.mdc', 'workflow.mdc', 'quality.mdc')
    'coding' = @('coding-standards.mdc', 'java.mdc', 'csharp.mdc')
    'architecture' = @('architecture-guidelines.mdc', 'architecture-lightweight.mdc', 'module-design-guidelines.mdc', 'adr-template.mdc')
    'frontend' = @('frontend.mdc', 'vue.mdc', 'wechat-mini-program.mdc')
    'practices' = @('testing.mdc', 'security.mdc', 'observability.mdc')
    'documentation' = @('document.mdc', 'feature-specification-guidelines.mdc')
    'misc' = @('代码解构与业务分析师.mdc')
}

# 移动文件
foreach ($category in $fileMapping.Keys) {
    foreach ($file in $fileMapping[$category]) {
        $sourcePath = Join-Path $rulesPath $file
        $destPath = Join-Path $rulesPath "$category\$file"
        
        if (Test-Path $sourcePath) {
            Move-Item -Path $sourcePath -Destination $destPath -Force
            Write-Host "移动: $file -> $category/"
        }
    }
}

Write-Host "`n重组完成！"

