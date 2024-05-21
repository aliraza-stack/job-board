import Dropdown from '@stimulus-components/dropdown'

export default class extends Dropdown {
  connect() {
    super.connect()
    console.log('Dropdown controller is active.');
  }

  toggle(event) {
    super.toggle()
  }

  hide(event) {
    super.hide(event)
  }
}
