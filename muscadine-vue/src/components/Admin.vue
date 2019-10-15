<template>
  <div class="admin">
    <h1>{{ title }}</h1>
    <hr>
    <p>Documentation</p>
    <p>Update Config</p>
    <p>Import Runners / Teams</p>
    <p>Team Results</p>
    <p>Team Results 2 (for publishing)</p>
    <p>Team Results 2 (for publishing)</p>
    <p>Individual Awards (based on AWT)</p>
    <p>Average Weighted Time</p>
  </div>
</template>

<script>
export default {
  name: 'admin',
  data () {
    return {
      title: '2020 Southeast Interschoolastic Championships'
    }
  }
}
</script>
