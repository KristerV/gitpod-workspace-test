FROM gitpod/workspace-base

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends inotify-tools

USER root

# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1

USER gitpod

WORKDIR /workspace
RUN	git clone https://github.com/asdf-vm/asdf.git /workspace/asdf --branch v0.11.3
RUN echo "---------------------------------------------------------------------------"
RUN pwd
RUN ls -alh /workspace/asdf
RUN echo ". "/workspace/asdf/asdf.sh"" >> /home/gitpod/.bashrc.d/100-asdf
RUN echo ". "/workspace/asdf/completions/asdf.bash"" >> /home/gitpod/.bashrc.d/100-asdf
ENV PATH=/workspace/asdf/bin:/workspace/asdf/shims:$PATH

RUN asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
RUN asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
RUN asdf install erlang 25.2.2
RUN asdf install elixir 1.14.4-otp-25
RUN asdf global erlang 25.2.2
RUN asdf global elixir 1.14.4-otp-25
