import styles from "../../../public/css/spiner.module.css";
export default function LoadingAdd() {

    return (
        <div className={styles.overlay}>
            <div className={styles.spinner}>
            </div>
        </div>
    )
}