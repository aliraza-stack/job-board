import Notification from '@stimulus-components/notification'

export default class extends Notification {
  connect() {
    super.connect()
    console.log('Notifications controller connected.')
  }
}