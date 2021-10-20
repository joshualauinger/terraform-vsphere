FROM hashicorp/terraform:0.12.29 as final
 
# Create provider plug-in directory
ARG plugins=/tmp/terraform.d/plugin-cache/linux_amd64
RUN mkdir -m 777 -p $plugins
  
# Download and unzip all required provider plug-ins from hashicorp to provider directory
RUN cd $plugins \
    && wget -q https://releases.hashicorp.com/terraform-provider-vsphere/2.0.2/terraform-provider-vsphere_2.0.2_linux_amd64.zip \
    && unzip *.zip \
    && rm *.zip
  
# For "terraform init" configure terraform CLI to use provider plug-in directory and not download from internet
ENV TF_CLI_ARGS_init="-plugin-dir=$plugins -get-plugins=false"
