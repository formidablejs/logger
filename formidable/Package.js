exports.Package = class Package {
  publish(language = 'imba') {
    const ext = language.toLowerCase() == 'imba'
      ? 'imba' : (
        language.toLowerCase() == 'typescript' ? 'ts' : 'imba'
      )

    const configKey = `config/logging.${ext}`;
    const configValue = `./formidable/config.${ext}`;

    return {
      config: {
        paths: {
          [configKey]: configValue
        }
      }
    }
  }
}
