const os = require("os");
const path = require("path");
const { execSync } = require("child_process");
const axios = require("axios");
const { releaseUrl, backendPath } = require("./constants");
const { silentLogger } = require("./logs");

const execCommand = (command) => {
  let options;

  if (os.platform() === "win32") {
    options = { shell: "powershell.exe" };
  }

  try {
    execSync(command, options);
  } catch (error) {
    silentLogger.error(error.stderr.toString());
  }
}

const downloadBackend = async () => {
  const { data } = await axios.get(releaseUrl);
  let command;
  
  if (os.platform() === "win32") {
    command = `Invoke-WebRequest "${data.tarball_url}" -OutFile PHLatest.tar.gz;
      New-Item backend -ItemType directory;
      tar -xzf PHLatest.tar.gz -C backend --strip-components=1;
      Remove-Item PHLatest.tar.gz;
      Set-Location backend;
      npm install;
      `;
  } else {
    command = `curl "${data.tarball_url}" -o PHLatest.tar.gz -L &&
      mkdir backend &&
      tar -xzf PHLatest.tar.gz -C backend --strip-components=1 &&
      rm PHLatest.tar.gz &&
      cd backend &&
      npm install`;
  }

  execCommand(command);
};

const checkForBackendUpdates = async () => {
  const currentVersion = require(path.join(
    backendPath,
    "package.json"
  )).version;
  const { data } = await axios.get(releaseUrl);
  const latestVersion = data.tag_name;

  if (currentVersion === latestVersion) {
    return { isLatestVersion: true };
  }

  return { isLatestVersion: false, latestTarballUrl: data.tarball_url };
};

const updateBackend = (tarballUrl) => {
  let command;

  if (os.platform() === "win32") {
    command = `Rename-Item ..\\backend ..\\backend2;
      Invoke-WebRequest "${tarballUrl}" -OutFile PHLatest.tar.gz;
      New-Item backend -ItemType directory;
      tar -xzf PHLatest.tar.gz -C backend --strip-components=1; 
      Move-Item backend2\\node_modules backend;
      Move-Item backend2\\results backend;
      Remove-Item backend2 -Recurse;
      Set-Location backend;
      npm install;
      `;
  } else {
    command = `mv backend backend2 && 
      curl "${tarballUrl}" -o PHLatest.tar.gz -L &&
      mkdir backend &&
      tar -xzf PHLatest.tar.gz -C backend --strip-components=1 && 
      mv backend2/node_modules backend &&
      mv backend2/results backend &&
      rm -r backend2 &&
      rm PHLatest.tar.gz &&
      cd backend && 
      npm install`;
  }

  execCommand(command);
};

module.exports = {
  downloadBackend,
  checkForBackendUpdates,
  updateBackend,
};