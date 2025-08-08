<?php
session_start();
require '../vendor/autoload.php';
include '../config/db.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

if (isset($_POST['export'])) {
    $tanggal = $_POST['tanggal'] ?? '';
    $bulan = $_POST['bulan'] ?? '';
    $tahun = $_POST['tahun'] ?? '';
    $kategori = $_POST['kategori'] ?? '';
    $jamaah = $_POST['jamaah'] ?? '';

    $query = "SELECT k.*, u.nama AS nama_jamaah 
              FROM keuangan_pemasukan k
              LEFT JOIN users u ON k.user_id = u.id
              WHERE 1";

    if (!empty($tanggal)) $query .= " AND k.tanggal = '$tanggal'";
    if (!empty($bulan)) $query .= " AND MONTH(k.tanggal) = '$bulan'";
    if (!empty($tahun)) $query .= " AND YEAR(k.tanggal) = '$tahun'";
    if (!empty($kategori)) $query .= " AND k.kategori = '$kategori'";
    if (!empty($jamaah) && $jamaah != 'all') $query .= " AND k.user_id = '$jamaah'";

    $query .= " ORDER BY k.tanggal ASC";
    $result = mysqli_query($conn, $query);

    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    $sheet->setCellValue('A1', 'No');
    $sheet->setCellValue('B1', 'Nama Jamaah');
    $sheet->setCellValue('C1', 'Kategori');
    $sheet->setCellValue('D1', 'Nominal');
    $sheet->setCellValue('E1', 'Keterangan');
    $sheet->setCellValue('F1', 'Tanggal');
    $sheet->setCellValue('G1', 'Status');

    $row = 2; $no = 1;
    while ($data = mysqli_fetch_assoc($result)) {
        $sheet->setCellValue('A'.$row, $no++);
        $sheet->setCellValue('B'.$row, $data['nama_jamaah'] ?? 'Tidak Diketahui');
        $sheet->setCellValue('C'.$row, ucfirst($data['kategori']));
        $sheet->setCellValue('D'.$row, $data['nominal']);
        $sheet->setCellValue('E'.$row, $data['keterangan']);
        $sheet->setCellValue('F'.$row, date('d-m-Y', strtotime($data['tanggal'])));
        $sheet->setCellValue('G'.$row, ucfirst($data['status']));
        $row++;
    }

    foreach (range('A','G') as $col) {
        $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    $fileName = "laporan_keuangan_" . date('Ymd_His') . ".xlsx";

    header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    header("Content-Disposition: attachment; filename=\"$fileName\"");
    header('Cache-Control: max-age=0');

    $writer = new Xlsx($spreadsheet);
    $writer->save('php://output');
    exit();
}
?>

<?php include 'layout/header.php'; ?>
<?php include 'layout/sidebar.php'; ?>

<div class="container-fluid">
    <h2 class="mb-4">Laporan Keuangan Masjid</h2>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-success text-white">Filter & Export Laporan</div>
        <div class="card-body">
            <form method="POST" class="row g-3">
                <div class="col-md-3">
                    <label>Tanggal</label>
                    <input type="date" name="tanggal" class="form-control">
                </div>
                <div class="col-md-3">
                    <label>Bulan</label>
                    <select name="bulan" class="form-select">
                        <option value="">-- Pilih Bulan --</option>
                        <?php
                        for ($m=1; $m<=12; $m++) {
                            echo "<option value='$m'>".date('F', mktime(0,0,0,$m,10))."</option>";
                        }
                        ?>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Tahun</label>
                    <select name="tahun" class="form-select">
                        <option value="">-- Pilih Tahun --</option>
                        <?php
                        $startYear = 2023;
                        $currentYear = date('Y');
                        for ($y = $startYear; $y <= $currentYear; $y++) {
                            echo "<option value='$y'>$y</option>";
                        }
                        ?>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Kategori</label>
                    <select name="kategori" class="form-select">
                        <option value="">Semua</option>
                        <option value="zakat">Zakat</option>
                        <option value="infaq">Infaq</option>
                        <option value="sedekah">Sedekah</option>
                    </select>
                </div>
<div class="col-md-6 mt-3">
    <label>Nama Jamaah</label>
    <select name="jamaah" class="form-select">
        <option value="all">Semua Jamaah</option>
        <?php
        $users = mysqli_query($conn, "SELECT id, nama FROM users WHERE role='user' ORDER BY nama ASC");
        while ($u = mysqli_fetch_assoc($users)) {
            echo "<option value='{$u['id']}'>{$u['nama']}</option>";
        }
        ?>
    </select>
</div>
                <div class="col-12 mt-3">
                    <button type="submit" name="export" class="btn btn-success w-100">
                        📥 Export ke Excel
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php include 'layout/footer.php'; ?>
