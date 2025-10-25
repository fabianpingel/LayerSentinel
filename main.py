import logging
import time
import datetime
import bambulabs_api as bl

from modules.config.settings import DEBUG_MODE
from modules.utils.secrets import get_secret, mask_secret


# Logging konfigurieren
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s | %(levelname)s | %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

# === Application Startup ===
def main() -> None:
    try:

        logging.info("🟢 Starte *LayerSentinel* by Pingel AI Solutions...")
        logging.info("🔌 Verbindung zum BambuLab 3D-Drucker herstellen...")

        IP = get_secret("IP")
        SERIAL = get_secret("SERIAL")
        ACCESS_CODE = get_secret("ACCESS_CODE")

        # Optional: Maskierte Logs
        logging.info(f"🌐 IP Addresse   : {IP}")
        logging.info(f"🔢 Seriennummer  : {SERIAL}")
        logging.info(f"🔐 Zugangscode   : {mask_secret(ACCESS_CODE)}")

        # Optional: Volle Secrets in Debug-Modus anzeigen (vorsichtig!)
        if DEBUG_MODE:
            logging.debug(f"[DEBUG] Access Code (unmasked): {ACCESS_CODE}")

        # Druckerinstanz erstellen
        printer = bl.Printer(IP, ACCESS_CODE, SERIAL)
        
        try:
            # Verbindung zum BambuLab 3D-Drucker herstellen
            logging.info("🔗 Versuche, Verbindung zum Drucker aufzubauen...")
            printer.connect()
            time.sleep(5)

            # Gcode Status des Druckers abfragen
            status = printer.get_state()
            logging.info(f"🖨️  Druckerstatus: {status}")

            if status.value != "UNKNOWN":
                # Optional: GCode Statusinformationen ausgeben
                printer_status = printer.get_current_state()
                logging.info(f"📊 Gcode Status: {printer_status}")

                # Optional: Licht einschalten
                light_status = printer.get_light_state()
                logging.info(f"💡 Lichtstatus: {'An' if light_status else 'Aus'}")
                if not light_status:
                    try:
                        printer.turn_light_on()
                        time.sleep(2)
                    except Exception as e:
                        logging.error(f"❌ Fehler beim Steuern des Druckers: {e}")

                if status.value == "PRINTING":
                    logging.info("🖨️ Druckvorgang läuft...")

                    while status.value == "PRINTING":

                        # Optional: Kamerabild abrufen und speichern
                        logging.info("📸 Starte Kameraüberwachung des Druckprozesses...")

                        try:
                            image = printer.get_camera_image()
                            logging.info(f"📸  Kamerbild aufgenommen")
                            image.save("example.png")
                        
                        except Exception as e:
                            logging.error(f"❌ Fehler beim Abrufen des Kamerabildes: {e}")

                        # Wartezeit zwischen den Abfragen
                        time.sleep(5)
                        # Gcode Status des Druckers aktualisieren
                        status = printer.get_state()

                        # Get the printer status
                        percentage = printer.get_percentage()
                        layer_num = printer.current_layer_num()
                        total_layer_num = printer.total_layer_num()
                        bed_temperature = printer.get_bed_temperature()
                        nozzle_temperature = printer.get_nozzle_temperature()
                        remaining_time = printer.get_time()
                        if remaining_time is not None:
                            finish_time = datetime.datetime.now() + datetime.timedelta(
                                minutes=int(remaining_time))
                            finish_time_format = finish_time.strftime("%Y-%m-%d %H:%M:%S")
                        else:
                            finish_time_format = "NA"

                        print(
                            f'''Printer status: {status}
                            Layers: {layer_num}/{total_layer_num}
                            percentage: {percentage}%
                            Bed temp: {bed_temperature} ºC
                            Nozzle temp: {nozzle_temperature} ºC
                            Remaining time: {remaining_time}m
                            Finish time: {finish_time_format}
                            '''
                        )


        except Exception as e:
            logging.error(f"❌ Fehler beim Verbinden oder Abrufen des Druckerstatus: {e}")
            return  # Beende die Funktion, wenn ein Fehler auftritt

        finally:
            # Verbindung zum Drucker trennen
            logging.info("🔌 Trenne Verbindung zum Drucker...")
            printer.disconnect()

    except Exception as e:
        logging.error(f"❌ Ein unerwarteter Fehler ist aufgetreten: {e}")
        return  # Beende die Funktion bei unerwarteten Fehlern


if __name__ == '__main__':
    main()







