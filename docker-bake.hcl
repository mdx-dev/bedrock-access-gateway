# If nonempty, give the built image an additional tag that differs only by
# ending in `$SUFFIX`. The default tag will also still be applied.
variable "SUFFIX" {
    default = ""
}

# If true, any built images will not be pushed.
variable "DRY" {
    default = false
}

target "default" {
    matrix = {
        application = [
            "bedrock-access-gateway"
        ],
        env = [
            {
                name = "prod"
                platforms = ["linux/arm64"]
                tag-suffix = ""
                output = ["type=registry"]
            },
            {
                name = "native"
                platforms = ["linux/arm64"]
                tag-suffix = "-native"
                output = ["type=docker"]
            }
        ]
    }
    name = "${application}-${env.name}"
    tags = ["vitals/services:${application}${env.tag-suffix}", "vitals/services:${application}${env.tag-suffix}${SUFFIX}"]
    target = application
    output = DRY ? ["type=docker"] : env.output
    platforms = env.platforms
    ssh = ["default"]
}
