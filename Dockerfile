# 使用 openEuler 22.03 镜像作为基础镜像
FROM openeuler/openeuler:22.03

# 设置环境变量，避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装依赖
RUN yum update -y && \
    yum install -y wget make gcc openssl-devel bzip2-devel libffi-devel zlib-devel \
                   ncurses-devel gdbm-devel sqlite-devel readline-devel tk-devel \
                   xz-devel uuid-devel libedit findutils
                   
# 下载并安装 Python 3.7.8
RUN wget https://www.python.org/ftp/python/3.7.8/Python-3.7.8.tgz && \
    tar xzf Python-3.7.8.tgz && \
    cd Python-3.7.8 && \
    ./configure --enable-optimizations && \
    make && \
    make altinstall && \
    ln -s /usr/local/bin/python3.7 /usr/bin/python3.7

# 验证 Python 安装
RUN python3.7 --version

# 安装 EPEL 仓库
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm --skip-broken

# 安装寒武纪 MagicMind 依赖包
RUN yum install -y https://sdk.cambricon.com/static/Basis/MLU370_X86_centos8.3/cntoolkit-3.7.2-1.el8.x86_64.rpm && \
    yum install -y cntoolkit-cloud cntoolkit-edge --skip-broken && \
    yum install -y https://sdk.cambricon.com/static/Basis/MLU370_X86_centos8.3/cnnl-1.21.1-1.el8.x86_64.rpm && \
    yum install -y https://sdk.cambricon.com/static/Basis/MLU370_X86_centos8.3/cnnlextra-1.5.0-1.el8.x86_64.rpm && \
    yum install -y https://sdk.cambricon.com/static/Basis/MLU370_X86_centos8.3/cnlight-0.22.0-1.abiold.el8.x86_64.rpm

# 安装寒武纪 MagicMind
RUN yum install -y https://sdk.cambricon.com/static/MagicMind/MLU370_v1.7.0_X86_centos8.3_python3.7_rpm/magicmind-1.7.0-1.el8.x86_64.rpm && \
    yum install -y https://sdk.cambricon.com/static/MagicMind/MLU370_v1.7.0_X86_centos8.3_python3.7_pip/magicmind-1.7.0-cp37-cp37m-linux_x86_64.whl
